class IssuesController < ApplicationController
  # GET /issues
  # GET /issues.json
  def index
    @magazine = Magazine.find(params[:magazine_id])
    @issues = @magazine.issues

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @issues }
    end
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
    @magazine = Magazine.find(params[:magazine_id])
    @issue = @magazine.issues.where(:id => params[:id]).first

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @issue }
    end
  end

  # GET /issues/new
  # GET /issues/new.json
  def new
    @magazine = Magazine.find(params[:magazine_id])
    @issue = @magazine.issues.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @issue }
    end
  end

  # GET /issues/1/edit
  def edit
    @magazine = Magazine.find(params[:magazine_id])
    @issue = @magazine.issues.where(:id => params[:id]).first
  end

  # POST /issues
  # POST /issues.json
  def create
    @magazine = Magazine.find(params[:magazine_id])
    @issue = @magazine.issues.create(params[:issue])
    @issue.uuid = UUID.new.generate

    respond_to do |format|
      if @issue.save
        format.html { redirect_to magazine_issues_path(@magazine), notice: 'Issue was successfully created.' }
        format.json { render json: @issue, status: :created, location: @issue }
      else
        format.html { render action: "new" }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PUT /issues/1
  # PUT /issues/1.json
  def update
    @magazine = Magazine.find(params[:magazine_id])
    @issue = @magazine.issues.find(params[:id])
    
    respond_to do |format|
      if @issue.update_attributes(params[:issue])
        format.html { redirect_to magazine_issue_url(@magazine, @issue), notice: 'Issue was successfully updated.' }        
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue = Issue.find(params[:id])
    @issue.destroy

    respond_to do |format|
      format.html { redirect_to magazine_issues_url(@magazine) }
      format.json { head :ok }
    end    
  end
end
