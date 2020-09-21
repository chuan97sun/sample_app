class CoursesController < ApplicationController
before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index
    @course = Course.order(:name).page params[:page]
  end

  def new
    @course = Course.new
  end
  
  def show
 
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:info] =  "course created"
      redirect_to courses_path
    else
      flash.now[:danger] = t "cannot be created"
      render :new
    end
  end

  def edit; end

  def update
    if @course.update course_params
      redirect_to @course
      flash[:success] =  "updated sucessfully"
    else
      flash.now[:danger] =  "cannot be updated"
      render :edit
    end
  end
  
  def destroy
    if @course.started? | @course.finished?
      redirect_to courses_path
      flash[:danger] = "you cant delete the started or finished course" 
    else @course.destroy
      redirect_to courses_path
      flash[:success] =  "deleted sucessfully"
    end
  end

  private 

  def course_params
    params.require(:course).permit :name, :introduction, :started_at, :member, :status, :total_month
  end

  def set_course
    @course = Course.find(params[:id])
  end
end
