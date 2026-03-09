module FormHelpers
  def submit_form
    find('input[name="commit"]').click
  end

  def select2(query, target, selector)
    expect(evaluate_script("$('#{selector}').select2('open')")).not_to be_empty

    expect(page).to have_selector(".select2-search__field")
    find(".select2-search__field").send_keys(query)
    wait_for_ajax
    find("li.select2-results__option", text: target).click
  end

  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until finished_all_ajax_requests?
    end
  end

  def finished_all_ajax_requests?
    page.evaluate_script("jQuery.active") == 0
  end
end
