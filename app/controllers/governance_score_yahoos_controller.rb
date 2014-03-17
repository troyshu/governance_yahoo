class GovernanceScoreYahoosController < ApplicationController
  before_action :set_governance_score_yahoo, only: [:show, :edit, :update, :destroy]

  # GET /governance_score_yahoos
  # GET /governance_score_yahoos.json
  def index
    @governance_score_yahoos = GovernanceScoreYahoo.all
  end

  # GET /governance_score_yahoos/1
  # GET /governance_score_yahoos/1.json
  def show
  end

  # GET /governance_score_yahoos/new
  def new
    @governance_score_yahoo = GovernanceScoreYahoo.new
  end

  # GET /governance_score_yahoos/1/edit
  def edit
  end

  # POST /governance_score_yahoos
  # POST /governance_score_yahoos.json
  def create
    @governance_score_yahoo = GovernanceScoreYahoo.new(governance_score_yahoo_params)

    respond_to do |format|
      if @governance_score_yahoo.save
        format.html { redirect_to @governance_score_yahoo, notice: 'Governance score yahoo was successfully created.' }
        format.json { render action: 'show', status: :created, location: @governance_score_yahoo }
      else
        format.html { render action: 'new' }
        format.json { render json: @governance_score_yahoo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /governance_score_yahoos/1
  # PATCH/PUT /governance_score_yahoos/1.json
  def update
    respond_to do |format|
      if @governance_score_yahoo.update(governance_score_yahoo_params)
        format.html { redirect_to @governance_score_yahoo, notice: 'Governance score yahoo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @governance_score_yahoo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /governance_score_yahoos/1
  # DELETE /governance_score_yahoos/1.json
  def destroy
    @governance_score_yahoo.destroy
    respond_to do |format|
      format.html { redirect_to governance_score_yahoos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_governance_score_yahoo
      @governance_score_yahoo = GovernanceScoreYahoo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def governance_score_yahoo_params
      params[:governance_score_yahoo]
    end
end
