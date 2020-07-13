class PagesController < ApplicationController
  def home
  	@beads = Bead.limit(50)
  end

  # def search
  	
  # 	if params[:search].present? && params[:search].strip != ""
  # 		session[:loc_search] = params[:search]
  # 	end

  # 	@arrResult = Array.new

  # 	@beads = @search.result

  # 	@arrbeads = @beads.to_a

  # 	if not_available.length > 0
  # 		@arrbeads.delete(bead)	
  # 	end

  # end
end