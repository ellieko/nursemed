require 'spec_helper'
require 'rails_helper'

describe MeetingsController do
  before :each do
    @controller = SessionsController.new
    post :create, {"session" => {"email" => "inco@gnito.com", "password" => "12345"}}

    @controller = MeetingsController.new
  end

  describe 'add a new meeting' do
    it 'should show the form to create new schedule' do
      get :new, :nurse_id => 2
      expect(response).to render_template('new')
    end
    it 'should create meeting successfully' do
      fake_meeting = double('Meeting', :nurse_id => 2, :student_id => 1, :start => Time.parse('2022-12-20 10:00:00 UTC'), :info => 'Regular Medication')
      allow(Meeting).to receive(:create).and_return (fake_meeting)
      fake_params = {:nurse_id => 2, :student_id => 1, :start => Time.parse('2022-12-20 10:00:00 UTC'), 'start(1i)' => '2022',
                     'start(2i)' => '12', 'start(3i)' => '20', 'start(4i)' => '10', 'start(5i)' => '00', :info => 'Regular Medication'}
      allow_any_instance_of(MeetingsController).to receive(:meeting_params).and_return (fake_params)
      post :create, :nurse_id => 2, :meeting => fake_params
      expect(response).to redirect_to(nurse_path(2))
    end
    it 'should have selected a student' do
      fake_params = {:nurse_id => 2, :student_id => '', :start => Time.parse('2022-12-20 10:00:00 UTC'), :info => 'Regular Medication',
                     'start(1i)' => '2022', 'start(2i)' => '12', 'start(3i)' => '20', 'start(4i)' => '10', 'start(5i)' => '00'}
      post :create, :nurse_id => 2, :meeting => fake_params
      expect(flash[:notice]).to eq("You must select a student to add a schedule. Please select one below.")
    end
    it 'should have selected an available time slot' do
      fake_params = {:nurse_id => 2, :student_id => 2, :start => Time.parse('2021-12-01 10:00:00 UTC'), :info => 'Regular Medication',
                     'start(1i)' => '2021', 'start(2i)' => '12', 'start(3i)' => '01', 'start(4i)' => '10', 'start(5i)' => '00'}
      post :create, :nurse_id => 2, :meeting => fake_params
      expect(flash[:notice]).to eq("The seleced time slot is not available. Please choose another time.")
    end
    it 'should redirect to new form again if adding was not successful' do
      fake_meeting = double('Meeting', :nurse_id => 2, :student_id => 1, :start => Time.parse('2021-12-01 17:30:00 UTC'), :info => 'Regular Medication')
      fake_params = {:nurse_id => 2, :student_id => 1, :start => Time.parse('2021-12-01 17:30:00 UTC'), :info => 'Regular Medication',
                     'start(1i)' => '2021', 'start(2i)' => '12', 'start(3i)' => '01', 'start(4i)' => '17', 'start(5i)' => '30'}
      allow_any_instance_of(MeetingsController).to receive(:meeting_params).and_return (fake_params)
      post :create, :nurse_id => 2, :meeting => fake_params
      expect(response).to redirect_to(new_nurse_meeting_path)
    end
    it 'should prevent duplicated booking' do
      fake_params_1 = {:nurse_id => 2, :student_id => 2, :start => Time.parse('2023-01-31 10:00:00 UTC'), :info => 'Regular Medication',
      'start(1i)' => '2023', 'start(2i)' => '01', 'start(3i)' => '31', 'start(4i)' => '10', 'start(5i)' => '00'}
      post :create, :nurse_id => 2, :meeting => fake_params_1
      fake_params_2 = {:nurse_id => 2, :student_id => 2, :start => Time.parse('2023-01-31 10:00:00 UTC'), :info => 'Regular Medication',
      'start(1i)' => '2023', 'start(2i)' => '01', 'start(3i)' => '31', 'start(4i)' => '10', 'start(5i)' => '00'}
      post :create, :nurse_id => 2, :meeting => fake_params_2
      expect(flash[:notice]).to eq("The seleced time slot is not available. Please choose another time.")
    end
  end

  describe 'logs a visit' do
    it 'should log a visit' do
      fake_meeting = double('Meeting', :nurse_id => 2, :student_id => 1, :start => Time.parse('2021-12-20 10:30:00 UTC'), :info => 'Regular Medication')
      allow(Meeting).to receive(:find).with('2').and_return(fake_meeting)
      expect(fake_meeting).to receive(:log).and_return('false')
      allow(fake_meeting).to receive(:log=)
      expect(fake_meeting).to receive(:save!)
      post :log, :nurse_id => 2, :id => 2
      expect(response).to redirect_to(nurse_path(2))
    end
    it 'should not allow relogging' do
      fake_meeting = double('Meeting', :nurse_id => 2, :student_id => 1, :start => Time.parse('2021-12-20 10:30:00 UTC'), :info => 'Regular Medication')
      allow(Meeting).to receive(:find).with('2').and_return(fake_meeting)
      expect(fake_meeting).to receive(:log).and_return('true')
      post :log, :nurse_id => 2, :id => 2
      expect(flash[:notice]).to eq("Meeting already has been logged. You cannot relog the meeting.")
    end
  end

  describe 'edit a meeting' do
    it 'should show the form to edit the meeting' do
      fake_meeting = double('Meeting', :nurse_id => 2, :student_id => 1, :start => Time.parse('2021-12-20 10:30:00 UTC'), :info => 'Regular Medication')
      allow(Meeting).to receive(:find).with('2').and_return(fake_meeting)
      get :edit, :nurse_id => 2, :id => 2
      expect(response). to render_template('edit')
    end
  end

  describe 'update a meeting' do
    it 'should save the updated meeting details' do
      fake_meeting = double('Meeting', :nurse_id => 2, :student_id => 1, :start => Time.parse('2021-12-20 10:30:00 UTC'), :info => 'Regular Medication')
      allow(Meeting).to receive(:find).with('2').and_return(fake_meeting)
      allow(fake_meeting).to receive(:update_attributes!)
      allow_any_instance_of(MeetingsController).to receive(:meeting_params).and_return(fake_meeting)
      put :update, :nurse_id => 2, :id => 2, :meeting => fake_meeting
      expect(response).to redirect_to(nurse_meeting_path(2, fake_meeting))
    end
  end

  describe 'cancel a meeting' do
    it 'should log a visit as canceled' do
      fake_meeting = double('Meeting', :id => 2, :nurse_id => 2, :student_id => 1, :start => Time.parse('2021-12-20 10:30:00 UTC'), :info => 'Regular Medication')
      expect(Meeting).to receive(:find).with('2').and_return(fake_meeting)
      expect(fake_meeting).to receive(:log).and_return('false')
      allow(fake_meeting).to receive(:log=)
      expect(fake_meeting).to receive(:save!)
      delete :destroy, :nurse_id => 2, :id => 2
      expect(response).to redirect_to(nurse_path(2))
    end

    it 'should not allow relogging' do
      fake_meeting = double('Meeting', :id => 2, :nurse_id => 2, :student_id => 1, :start => Time.parse('2021-12-20 10:30:00 UTC'), :info => 'Regular Medication')
      expect(Meeting).to receive(:find).with('2').and_return(fake_meeting)
      expect(fake_meeting).to receive(:log).and_return('true')
      delete :destroy, :nurse_id => 2, :id => 2
      expect(flash[:notice]).to eq("Meeting already has been canceled. You cannot relog the meeting.")
    end
  end

  describe 'show meeting history' do
    it 'should show list of meetings happened till yesterday' do
      fake_nurse = double('Nurse')
      fake_results = [double('Meeting'), double('Meeting')]
      allow(fake_nurse).to receive(:meetings).and_return(fake_results)
      get :index, :nurse_id => 2
      expect(response).to render_template('index')
      end
    end

    describe 'Reporting error ' do
      it 'should retrieve the meeting with the nurse and student'do
        meeting = double(:date => "15-Nov-2021", :student_id => 1, :nurse_id =>1, :info=>'meeting')
        allow(Meeting).to receive(:find).with('1').and_return(meeting)
        post :error, {:id => 1, :nurse_id => 1}
        expect(response).to render_template('error')
      end
  
  
    end
  
  
    describe 'adding Error' do
  
      it 'should retrieve the meeting with the nurse and student'do
        meeting = double(:date => "15-Nov-2021", :student_id => 1, :nurse_id =>1, :info=>'meeting')
        allow(Meeting).to receive(:find).with('1').and_return(meeting)
      end
  
      it 'should update the meeting attributes' do
        post :adderror, :nurse_id => 1, :id => '1', :meeting => {:error => "wrong dose", :mitigation => "Nothing lol" }
        expect(response).to redirect_to(nurse_path(1))
      end
  
  
  
      it 'should redirect to the nurse meeting page' do
        meeting = double(:date => "15-Nov-2021", :student_id => 1, :nurse_id =>1, :info=>'meeting')
        #allow(Meeting).to receive(:find).with('1').and_return(meeting)
        #allow(meeting).to receive(:update_attributes!)
        #allow_any_instance_of(MeetingsController).to receive(:meeting_params).and_return (meeting)
        post :adderror, :nurse_id => 1, :id => '1', :meeting => {:error => "wrong dose", :mitigation => "Nothing lol" }
        expect(response).to redirect_to(nurse_path(1))
      end
  
  
    end


  describe 'should filter out users' do

    it 'should redirect students from index'do
      @controller = SessionsController.new
      post :create, {"session" => {"email" => "david@wang.com", "password" => "12345"}}

      @controller = MeetingsController.new
      get :index, nurse_id: 1
      expect(response).to redirect_to(login_path)
    end
    it 'should redirect administrators from new'do
      @controller = SessionsController.new
      post :create, {"session" => {"email" => "hell@bear.com", "password" => "12345"}}

      @controller = MeetingsController.new
      get :new, nurse_id: 1
      expect(response).to redirect_to(login_path)
    end

    it 'should redirect administrators from new'do
      @controller = SessionsController.new
      post :create, {"session" => {"email" => "hell@bear.com", "password" => "12345"}}

      @controller = MeetingsController.new
      get :new, nurse_id: 1
      expect(response).to redirect_to(login_path)
    end

    it 'should allow administrators to index'do
      @controller = SessionsController.new
      post :create, {"session" => {"email" => "hell@bear.com", "password" => "12345"}}

      @controller = MeetingsController.new
      get :index, nurse_id: 1
      expect(response).to render_template('index')
    end


    it 'should allow nurse to index'do
      @controller = SessionsController.new
      post :create, {"session" => {"email" => "inco@gnito.com", "password" => "12345"}}

      @controller = MeetingsController.new
      get :index, nurse_id: 1
      expect(response).to render_template('index')
    end

    it 'should allow nurse to show'do
      @controller = SessionsController.new
      post :create, {"session" => {"email" => "inco@gnito.com", "password" => "12345"}}

      @controller = MeetingsController.new
      get :show, nurse_id: 1, id: 1
      expect(response).to render_template('show')
    end

    it 'should allow student to correct student show'do
      @controller = SessionsController.new
      post :create, {"session" => {"email" => "david@wang.com", "password" => "12345"}}

      @controller = MeetingsController.new
      get :show, nurse_id: 1, id: 1
      expect(response).to render_template('show')
    end

    it 'should allow guardian to correct student show'do
      @controller = SessionsController.new
      post :create, {"session" => {"email" => "steven@steel.com", "password" => "12345"}}

      @controller = MeetingsController.new
      get :show, nurse_id: 1, id: 1
      expect(response).to render_template('show')
    end

    it 'should redirect guardian from wrong student show' do
      @controller = SessionsController.new
      post :create, {"session" => {"email" => "steven@steel.com", "password" => "12345"}}

      @controller = MeetingsController.new
      get :show, nurse_id: 2, id: 2
      expect(response).to redirect_to(login_path)
    end

    it 'should redirect student from wrong student show' do
      @controller = SessionsController.new
      post :create, {"session" => {"email" => "david@wang.com", "password" => "12345"}}

      @controller = MeetingsController.new
      get :show, nurse_id: 2, id: 2
      expect(response).to redirect_to(login_path)
    end
  end
end