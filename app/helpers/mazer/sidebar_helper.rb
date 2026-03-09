module Mazer
  module SidebarHelper
    # EXAMPLE
    #
    # def admin_sidebar_active
    #   case params[:controller]
    #   when 'user/general_pages'
    #     return 0
    #   when 'user/users'
    #     case params[:role]
    #     when 'partnerships'
    #       return 1, 1.1
    #     when 'merchants'
    #       return 1, 1.2
    #     else
    #       return 1, 1.1
    #     end
    #
    #   end
    # end

    def mazer_admin_sidebar_active
      case params[:controller]
      when 'admin/admins'
        0
      when 'admin/consents'
        1
        # scaffold_mazer admin insert - do not remove this comment
      end
    end

    def mazer_sidebar_active_to_class(value1, value2)
      return unless value1 == value2

      'active'
    end

    def option_sidebar_brand_name
      'Admin'
    end
  end
end
