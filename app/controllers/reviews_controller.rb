class ReviewsController < ApplicationController
before_action :set_course
before_action :set_review, only: [:edit, :update, :destroy]
  def index
    
  end

  def new
    @review = Review.new
  end
  
  def create
    @review = Review.new review_params
    @review.course_id = @course.id
    @review.user_id = current_user.id
    if @review.save
      flash[:info] =  "review created"
      redirect_to course_path(@course)
    else
      flash.now[:danger] = t "cannot be created"
      render :new
    end
  end

  def edit; end

  def update
    if @review.update review_params
      redirect_to course_path(@course)
      flash[:success] =  "updated sucessfully"
    else
      flash.now[:danger] =  "cannot be updated"
      render :edit
    end
  end
  
  def destroy
    if @review.destroy
      redirect_to course_path(@course)
      flash[:success] =  "deleted sucessfully"
    end
  end

  
  private 

  def review_params
    params.require(:review).permit :content
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_review
    @review = Review.find_by (params[:id])
  end

end

