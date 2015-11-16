module ApplicationHelper
    def is_active(sort_by)       
        params[:sort_by] == sort_by ? "hilite" : nil        
    end
end
