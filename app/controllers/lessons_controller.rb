class LessonsController < ApplicationController
  before_action :set_course
  before_action :set_lesson, only: [ :show, :edit, :update, :destroy ]

  def index
    @lessons = @course.lessons
  end

  def show
    @course = Course.find(params[:id])
    @lessons = @course.lessons
  end


  def new
    @lesson = @course.lessons.build
  end

  def create
    @lesson = @course.lessons.build(lesson_params)
    @lesson.user = current_user  # Прив’язка автора уроку

    if @lesson.save
      redirect_to course_path(@course), notice: "Урок створено успішно"
    else
      render :new, status: :unprocessable_entity
    end
  end


  def edit
  end

  def update
    if @lesson.update(lesson_params)
      redirect_to course_lesson_path(@course, @lesson), notice: "Урок оновлено"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @lesson.destroy
    redirect_to course_lessons_path(@course), notice: "Урок видалено"
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_lesson
    @lesson = @course.lessons.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:title, :content)
  end
end
