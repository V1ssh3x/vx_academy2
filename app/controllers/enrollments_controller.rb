class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: %i[ show edit update destroy ]

  # GET /enrollments or /enrollments.json
  def index
    @enrollments = Enrollment.all
  end

  # GET /enrollments/1 or /enrollments/1.json
  def show
  end

  # GET /enrollments/new
  def new
    @enrollment = Enrollment.new
  end

  # GET /enrollments/1/edit
  def edit
  end

  # POST /enrollments or /enrollments.json
  def create
    @enrollment = current_user.enrollments.build(course_id: params[:course_id], status: "pending")


    if @enrollment.save
      redirect_to courses_path, notice: "Успішно записано на курс!"
    else
      redirect_to courses_path, alert: "Не вдалося записатися."
    end
  end


  # PATCH/PUT /enrollments/1 or /enrollments/1.json
  def update
    respond_to do |format|
      if @enrollment.update(enrollment_params)
        format.html { redirect_to @enrollment, notice: "Enrollment was successfully updated." }
        format.json { render :show, status: :ok, location: @enrollment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enrollments/1 or /enrollments/1.json
  def destroy
    @enrollment = Enrollment.find(params[:id])

    # Перевірка, що запис належить поточному користувачу
    if @enrollment.user == current_user
      @enrollment.destroy
      redirect_to my_courses_path, notice: "Запис скасовано."
    else
      redirect_to my_courses_path, alert: "Немає доступу для скасування цього запису."
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enrollment
      @enrollment = Enrollment.find(params[:id])
    end

    def enrollment_params
      params.require(:enrollment).permit(:user_id, :course_id, :status)
    end
end
