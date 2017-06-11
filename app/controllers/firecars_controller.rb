class FirecarsController < ApplicationController
  before_action :set_firecar, only: [:show, :edit, :update, :destroy]

  # GET /firecars
  # GET /firecars.json
  def index
    @firecars = Firecar.all
  end

  # GET /firecars/1
  # GET /firecars/1.json
  def show
  end

  # GET /firecars/new
  def new
    @firecar = Firecar.new
  end

  # GET /firecars/1/edit
  def edit
  end

  # POST /firecars
  # POST /firecars.json
  def create
    @firecar = Firecar.new(firecar_params)

    respond_to do |format|
      if @firecar.save
        format.html { redirect_to @firecar, notice: 'Firecar was successfully created.' }
        format.json { render :show, status: :created, location: @firecar }
      else
        format.html { render :new }
        format.json { render json: @firecar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /firecars/1
  # PATCH/PUT /firecars/1.json
  def update
    respond_to do |format|
      if @firecar.update(firecar_params)
        format.html { redirect_to @firecar, notice: 'Firecar was successfully updated.' }
        format.json { render :show, status: :ok, location: @firecar }
      else
        format.html { render :edit }
        format.json { render json: @firecar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /firecars/1
  # DELETE /firecars/1.json
  def destroy
    @firecar.destroy
    respond_to do |format|
      format.html { redirect_to firecars_url, notice: 'Firecar was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_firecar
      @firecar = Firecar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def firecar_params
      params.fetch(:firecar, {})
    end
end
