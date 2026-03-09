class CheckGoalsJob < ApplicationJob

  def perform
    Goal.where(end_date: Date.current, status: :in_progress).find_each do |goal|
      status = goal.current_amount_cents >= goal.target_amount_cents ? :achieved : :failed
      check_group_members(goal, status)
    end

    Goal.where(start_date: Date.current, status: :scheduled).find_each do |goal|
      check_group_members(goal, :in_progress)
    end
  end

  def check_group_members(goal, status)
    goal.group.members.each do |member|
      handle_goal_mail(member, goal, status)
    end
  end

  def handle_goal_mail(member, goal, status)
    return if member.user.nil?

    case status
    when :achieved
      GoalMailer.with(user: member.user, goal: goal).goal_achieved.deliver_now
      goal.update!(status: status)
    when :failed
      GoalMailer.with(user: member.user, goal: goal).goal_failed.deliver_now
      goal.update!(status: status)
    else
      GoalMailer.with(user: member.user, goal: goal).goal_started.deliver_now
      goal.update!(status: status)
    end
  end
end
