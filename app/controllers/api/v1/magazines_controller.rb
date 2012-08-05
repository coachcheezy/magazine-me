class Api::V1::MagazinesController < Api::ApiController
  
  def index
    magazines = Magazine.all
    return render_jsend(:magazines => magazines)
  end
    
end
