class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def show
    @student = Student.includes(:sections).find(params[:id])
    @student_sections = StudentSectionService.new.call(@student)
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to @student, notice: 'Student was successfully created.'
    else
      render :new
    end
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    if @student.update(student_params)
      redirect_to @student, notice: 'Student was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    redirect_to students_url, notice: 'Student was successfully destroyed.'
  end

  def add_section
    @student = Student.find(params[:id])
    section = Section.find(params[:section_id])

    if @student.student_sections.build(section: section) && @student.save
      redirect_to student_path(@student), notice: 'Section was successfully added.'
    else
      flash[:alert] = @student.errors.full_messages.join(', ')
      redirect_to student_path(@student)
    end
  end

  def remove_section
    @student = Student.find(params[:id])
    section = Section.find(params[:section_id])
    @student.sections.delete(section)
    redirect_to @student, notice: 'Section was successfully removed.'
  end

  private

  def student_params
    params.require(:student).permit(:first_name, :last_name)
  end
end
