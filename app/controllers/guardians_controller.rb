class GuardiansController < ApplicationController
  def show
    @guardian = nil
    id = params[:id]
    if @current_user.student
      guardian_list = @current_user.student.guardians.select {|guardian| guardian.id == id}
      if guardian_list.empty?
        redirect_to login_path
        return
      else
        @guardian = guardian_list[0]
      end
    elsif @current_user.guardian
      @guardian = @current_user.guardian
    end

    if not @guardian
      @guardian = Guardian.find(id)
    end

    @meetings = []
    @guardian.students.each do |student|
      @meetings += student.meetings
    end
  end
end
