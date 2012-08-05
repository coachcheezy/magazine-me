class PagesController < ApplicationController
  # GET /pages
  # GET /pages.json
  def index
    @magazine = Magazine.find(params[:magazine_id])
    @issue = Issue.find(params[:issue_id])
    @pages = @issue.pages

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    @magazine = Magazine.find(params[:magazine_id])
    @issue = Issue.find(params[:issue_id])
    @page = @issue.pages.where(:id => params[:id]).first
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    @magazine = Magazine.find(params[:magazine_id])
    @issue = Issue.find(params[:issue_id])
    @page = @issue.pages.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @magazine = Magazine.find(params[:magazine_id])
    @issue = Issue.find(params[:issue_id])
    @page = @issue.pages.where(:id => params[:id]).first
  end

  # POST /pages
  # POST /pages.json
  def create    
    @magazine = Magazine.find(params[:magazine_id])
    @issue = Issue.find(params[:issue_id])
    @page = @issue.pages.create(params[:page])

    respond_to do |format|
      if @page.save
        format.html { redirect_to magazine_issue_pages_path(@magazine, @issue), notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update    
    @magazine = Magazine.find(params[:magazine_id])
    @issue = Issue.find(params[:issue_id])
    @page = @issue.pages.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to magazine_issue_page_url(@magazine, @issue, @page), notice: 'Page was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to magazine_issue_pages_url(@magazine, @issue) }
      format.json { head :ok }
    end
  end
end
