module ApplicationHelper
    def is_active(sort_by)       
        session[:sort_by] == sort_by ? "hilite" : nil        
    end
end
