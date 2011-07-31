class EvolutionsController < ApplicationController
	skip_before_filter :authorize, :only => :index
  # GET /evolutions
  # GET /evolutions.xml
  def index
    @evolutions = Evolution.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @evolutions }
    end
  end

  # GET /evolutions/1
  # GET /evolutions/1.xml
  def show
    @evolution = Evolution.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @evolution }
    end
  end

  # GET /evolutions/new
  # GET /evolutions/new.xml
  def new
    @evolution = Evolution.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @evolution }
    end
  end

  # GET /evolutions/1/edit
  def edit
    @evolution = Evolution.find(params[:id])
  end

  # POST /evolutions
  # POST /evolutions.xml
  def create
		last_evolution = Evolution.first
		main_version_str = Time.now.strftime("%y.%m.%d")
		sub_version = 1

		if last_evolution
			sub_version = last_evolution.version.include?(main_version_str) ? last_evolution.version.split('.').last.to_i + 1 : 1
		end 

		sub_version_str = sub_version < 10 ? '0' + sub_version.to_s : sub_version.to_s
		version = main_version_str + '.' + sub_version_str
		@evolution = Evolution.new(:change => params[:evolution][:change], :version => version)

    respond_to do |format|
      if @evolution.save
        format.html { redirect_to(@evolution, :notice => 'Evolution was successfully created.') }
        format.xml  { render :xml => @evolution, :status => :created, :location => @evolution }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @evolution.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /evolutions/1
  # PUT /evolutions/1.xml
  def update
    @evolution = Evolution.find(params[:id])

    respond_to do |format|
      if @evolution.update_attributes(params[:evolution])
        format.html { redirect_to(@evolution, :notice => 'Evolution was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @evolution.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /evolutions/1
  # DELETE /evolutions/1.xml
  def destroy
    @evolution = Evolution.find(params[:id])
    @evolution.destroy

    respond_to do |format|
      format.html { redirect_to(evolutions_url) }
      format.xml  { head :ok }
    end
  end
end
