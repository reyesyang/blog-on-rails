class AcknowledgesController < ApplicationController
	skip_before_filter :authorize, :only => :index
  # GET /acknowledges
  # GET /acknowledges.xml
  def index
    @acknowledges = Acknowledge.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @acknowledges }
    end
  end

  # GET /acknowledges/1
  # GET /acknowledges/1.xml
  def show
    @acknowledge = Acknowledge.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @acknowledge }
    end
  end

  # GET /acknowledges/new
  # GET /acknowledges/new.xml
  def new
    @acknowledge = Acknowledge.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @acknowledge }
    end
  end

  # GET /acknowledges/1/edit
  def edit
    @acknowledge = Acknowledge.find(params[:id])
  end

  # POST /acknowledges
  # POST /acknowledges.xml
  def create
    @acknowledge = Acknowledge.new(params[:acknowledge])

    respond_to do |format|
      if @acknowledge.save
        format.html { redirect_to(@acknowledge, :notice => 'Acknowledge was successfully created.') }
        format.xml  { render :xml => @acknowledge, :status => :created, :location => @acknowledge }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @acknowledge.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /acknowledges/1
  # PUT /acknowledges/1.xml
  def update
    @acknowledge = Acknowledge.find(params[:id])

    respond_to do |format|
      if @acknowledge.update_attributes(params[:acknowledge])
        format.html { redirect_to(@acknowledge, :notice => 'Acknowledge was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @acknowledge.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /acknowledges/1
  # DELETE /acknowledges/1.xml
  def destroy
    @acknowledge = Acknowledge.find(params[:id])
    @acknowledge.destroy

    respond_to do |format|
      format.html { redirect_to(acknowledges_url) }
      format.xml  { head :ok }
    end
  end
end
