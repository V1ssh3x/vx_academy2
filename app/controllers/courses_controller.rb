class CoursesController < ApplicationController
  before_action :set_course, only: [ :show, :edit, :update, :destroy ]
  before_action :require_login, only: [ :my_courses ] # Якщо потрібна авторизація
  before_action :authorize_owner!, only: [ :edit, :update, :destroy ]
  before_action :require_teacher!, only: [ :new, :create, :edit, :update, :destroy ]

  # GET /courses
  def index
    @courses = Course.all
  end

  # GET /courses/1
  def show
    @course = Course.find(params[:id])
    @lessons = @course.lessons
  end

  # GET /my-courses
  def my_courses
    # Курси, на які підписаний користувач через enrollments
    @courses = current_user.enrolled_courses.includes(:enrollments)
    # Для зручності пошуку підписки на кожен курс
    @enrollments_by_course = current_user.enrollments.index_by(&:course_id)
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
    # @course встановлений set_course
  end

  # POST /courses
  def create
    @course = current_user.courses.build(course_params)

    if @course.save
      redirect_to @course, notice: "Course was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /courses/1
  def update
    if @course.update(course_params)
      redirect_to @course, notice: "Курс оновлено"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /courses/1
  def destroy
    @course.destroy
    redirect_to courses_path, notice: "Курс успішно видалено"
  end

  private

  def authorize_owner!
    unless @course.user == current_user
      redirect_to courses_path, alert: "Ви не маєте прав для цієї дії."
    end
  end

  def set_course
    @course = Course.find(params[:id])
  end

  def require_teacher!
    unless current_user&.role == "teacher"
      redirect_to courses_path, alert: "Доступно лише для викладачів."
    end
  end

  def course_params
    params.require(:course).permit(:title, :description, :image, :category)
  end
end
