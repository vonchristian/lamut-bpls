module BploSection
  module Settings
    class DepartmentsController < ApplicationController
      def new
        @department = BploSection::Settings::Department.new
        authorize @department
      end
      def create
        @department = BploSection::Settings::Department.create(department_params)
        authorize @department
        
        if @department.save
          redirect_to bplo_section_settings_url, notice: "Department created successfully"
        else
          render :new
        end
      end

      private
      def department_params
        params.require(:bplo_section_settings_department).permit(:name)
      end
    end
  end
end
