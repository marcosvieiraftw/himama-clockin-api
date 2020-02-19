class Api::V1::ClockinRecordsController < Api::V1::ApiV1Controller
  before_action :set_api_v1_clockin_record, only: [:show, :update, :destroy]

  # GET /api/v1/clockin_records
  def index
    authorize ClockinRecord
    query = params[:type]

    if query.present?
      @api_v1_clockin_records = ClockinRecord.search_by_type(query).where(user_id: current_user.id)
    else
      @api_v1_clockin_records = policy_scope(ClockinRecord.all)
    end

    @pagy, @api_v1_clockin_records = pagy(@api_v1_clockin_records)
    options = { meta: pagy_metadata(@pagy) }
    render json: Api::V1::ClockinRecordSerializer.new(@api_v1_clockin_records, options).serialized_json
  end

  # GET /api/v1/clockin_records/1
  def show
    authorize ClockinRecord
    render json: Api::V1::ClockinRecordSerializer.new(@api_v1_clockin_record).serialized_json
  end
  # POST /api/v1/clockin_records

  def create
    authorize ClockinRecord
    @api_v1_clockin_record = ClockinRecord.new(api_v1_clockin_record_params)
    @api_v1_clockin_record.user = current_user

    if @api_v1_clockin_record.save
      render json: Api::V1::ClockinRecordSerializer.new(@api_v1_clockin_record).serialized_json, status: :created
    else
      render json: @api_v1_clockin_record.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/clockin_records/1
  def update
    authorize ClockinRecord
    if @api_v1_clockin_record.update(api_v1_clockin_record_params)
      render json: Api::V1::ClockinRecordSerializer.new(@api_v1_clockin_record).serialized_json
    else
      render json: @api_v1_clockin_record.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/clockin_records/1
  def destroy
    authorize ClockinRecord
    # Since the user can delete their records, I decided to use soft delete to keep it physically in the database
    # in case an admin needs to audit these deleted records.
    @api_v1_clockin_record.soft_delete!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_api_v1_clockin_record
    @api_v1_clockin_record = ClockinRecord.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def api_v1_clockin_record_params
    params.require(:clockin_record).permit(:register_type, :register_date)
  end
end
