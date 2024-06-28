class SectionsController < ApplicationController
  before_action :set_teacher_subject, only: %i[new create edit update]

  def index
    @sections = Section.all
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      redirect_to @section, notice: 'Section was successfully created.'
    else
      render :new
    end
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.find(params[:id])
    if @section.update(section_params)
      redirect_to @section, notice: 'Section was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @section = Section.find(params[:id])
    @section.destroy
    redirect_to sections_url, notice: 'Section was successfully destroyed.'
  end

  private

  def section_params
    params.require(:section).permit(:teacher_subject_id, :classroom_id, :start_time, :end_time, :days)
  end

  def set_teacher_subject
    @teacher_subjects = TeacherSubject.joins(:subject).select('teacher_subjects.id, subjects.name')
  end
end
