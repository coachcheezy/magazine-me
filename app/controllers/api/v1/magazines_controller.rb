class Api::V1::MagazinesController < Api::ApiController
  
  def index
    magazines = Magazine.all
    return render_jsend(:magazines => magazines)
  end
  
  def issues
    magazine = Magazine.find(params[:magazine_id])
    if magazine.issues.any?
      return render_jsend(:issues => magazine.issues)      
    end
  end
  
  def pages
    @magazine = Magazine.find(params[:magazine_id])
    @issue = Issue.find(params[:id])
    @pages = @issue.pages.order(:page_number)
    
    if @pages.any?
      return render_jsend(:pages => @pages)      
    end
  end
    
end
