require 'spec_helper'
require 'rails_helper'

describe StudentsController do

  before :each do
    @controller = SessionsController.new
    post :create, {"session" => {"email" => "inco@gnito.com", "password" => "12345"}}

    @controller = StudentsController.new
    @user = double('User', :first_name => 'John', :last_name => 'Smith', :email => "a@a.com",
                   :student => nil, :guardian => nil, :administrator => nil, :nurse => nil)
    @student = double('Student', :id => '1', :user => @user)
    @nurse = double('Nurse', :id => '1', :user => @user)
    allow(@user).to receive(:nurse).and_return(@nurse)
    allow(User).to receive(:find_by_session_token).and_return(@user)
  end

  describe 'show form to add student' do
    it 'should show the form for user to create new student information' do
      get(:new, params: {})
      expect(response).to render_template('new')
    end
  end

  describe 'login redirect' do
    it 'should redirect to login on other pages when not logged in' do

      @controller = SessionsController.new
      post :destroy
      @controller = StudentsController.new

      allow(User).to receive(:find_by_session_token).and_return(nil)
      get :index
      expect(response).to redirect_to('/login')
    end
  end
  describe 'create a student' do

    it 'should create student successfully' do
      student = double('Student', :first_name => 'John', :last_name => 'Smith', :school_id => 2, :birthdate => '01-Jan-2000')
      hash = {:school_id => 2, :birthdate => '01-Jan-2000'}

      allow(@user).to receive(:nurse).and_return(double("Nurse", :school_id => 1))
      allow(Student).to receive(:create!).and_return (student)

      allow_any_instance_of(StudentsController).to receive(:student_params).and_return (hash)

      allow_any_instance_of(StudentsController).to receive(:user_params).and_return ({:first_name => 'John', :last_name => 'Smith', :email => "a@a.com"})
      allow_any_instance_of(StudentsController).to receive(:guardian_params).and_return ({:first_name => 'John', :last_name => 'Smith', :email => "b@b.com"})


      post(:create, params: {:student => hash})
      expect(response).to redirect_to(students_path)
    end

    it 'should fail student creation with same email for guardian' do
      student = double('Student', :first_name => 'John', :last_name => 'Smith', :school_id => 2, :birthdate => '01-Jan-2000')
      hash = {:school_id => 2, :birthdate => '01-Jan-2000'}

      allow(@user).to receive(:nurse).and_return(double("Nurse", :school_id => 1))
      allow(Student).to receive(:create!).and_return (student)

      allow_any_instance_of(StudentsController).to receive(:student_params).and_return (hash)

      allow_any_instance_of(StudentsController).to receive(:user_params).and_return ({:first_name => 'John', :last_name => 'Smith', :email => "inco@gnito.com"})
      allow_any_instance_of(StudentsController).to receive(:guardian_params).and_return ({:first_name => 'John', :last_name => 'Smith', :email => "inco@gnito.com"})


      post(:create, params: {:student => hash})
      expect(response).to redirect_to(new_student_path)
    end


      it 'should fail student creation with existing email (student)' do
        student = double('Student', :first_name => 'John', :last_name => 'Smith', :school_id => 2, :birthdate => '01-Jan-2000')
        hash = {:school_id => 2, :birthdate => '01-Jan-2000'}

        allow(@user).to receive(:nurse).and_return(double("Nurse", :school_id => 1))
        allow(Student).to receive(:create!).and_return (student)
        allow_any_instance_of(StudentsController).to receive(:student_params).and_return (hash)

        allow_any_instance_of(StudentsController).to receive(:user_params).and_return ({:first_name => 'John', :last_name => 'Smith', :email => "inco@gnito.com"})
        allow_any_instance_of(StudentsController).to receive(:guardian_params).and_return ({:first_name => 'John', :last_name => 'Smith', :email => "a@a.com"})


        post(:create, params: {:student => hash})
        expect(response).to redirect_to(new_student_path)
      end

    it 'should fail student creation with existing email (guardian)' do
      student = double('Student', :first_name => 'John', :last_name => 'Smith', :school_id => 2, :birthdate => '01-Jan-2000')
      hash = {:school_id => 2, :birthdate => '01-Jan-2000'}
      allow(@user).to receive(:nurse).and_return(double("Nurse", :school_id => 1))
      allow(Student).to receive(:create!).and_return (student)

      allow_any_instance_of(StudentsController).to receive(:student_params).and_return (hash)

      allow_any_instance_of(StudentsController).to receive(:user_params).and_return ({:first_name => 'John', :last_name => 'Smith', :email => "a@a.com"})
      allow_any_instance_of(StudentsController).to receive(:guardian_params).and_return ({:first_name => 'John', :last_name => 'Smith', :email => "inco@gnito.com"})


      post(:create, params: {:student => hash})
      expect(response).to redirect_to(new_student_path)
    end

  end

  describe 'edit a student' do
    it 'should show the form to edit the student info' do
      student = double('Student', :first_name => 'John', :last_name => 'Smith', :school_id => 2, :birthdate => '01-Jan-2000')
      hash = {:school_id => 2, :birthdate => '01-Jan-2000'}
      fake_guardians = double('List')
      allow(fake_guardians).to receive(:first).and_return student
      allow(student).to receive(:guardians).and_return (fake_guardians)


      allow(Student).to receive(:find).with('1').and_return(student)
      get :edit, :id => '1'
      expect(response). to render_template('edit')
    end
  end


  describe 'transfer a student' do
    before :each do
      @controller = SessionsController.new
      post :create, {"session" => {"email" => "hell@bear.com", "password" => "12345"}}

      @controller = StudentsController.new

      allow(User).to receive(:find_by_session_token).and_return(User.find_by_email("hell@bear.com"))
    end
    it 'should show the form to edit the student school' do
      get :transfer, :id => '1'
      expect(response). to render_template('transfer')
    end
    it 'should assign student' do
      get :transfer, :id => '1'
      expect(assigns(:student)). to eq(Student.find(1))
    end
    it 'should assign schools' do
      get :transfer, :id => '1'
      expect(assigns(:schools)). to eq(School.all)
    end

    it 'should redirect to student show page' do
      post :transfer_update, {:id => '1', "school" => "2"}
      expect(response). to redirect_to(student_path(1))
    end
    it 'should update student school' do
      post :transfer_update, {:id => '1', "school" => "2"}
      expect(Student.find(1).school).to eq(School.find(2))
    end
  end

  describe 'update a student' do
    it 'should save the updated student info' do
      student = double('Student', :first_name => 'John', :last_name => 'Smith', :school_id => 2, :birthdate => '01-Jan-2000')
      hash = {:first_name => "Arg"}
      fake_user = double('User')
      allow(fake_user).to receive(:update_attributes!)
      allow(fake_user).to receive(:first_name)
      allow(fake_user).to receive(:last_name)
      fake_guardian = double('Guardian')
      allow(fake_guardian).to receive(:user).and_return(fake_user)
      allow(fake_guardian).to receive(:find).and_return(fake_guardian)
      allow(Student).to receive(:find).with('1').and_return(student)
      allow(student).to receive(:update_attributes!)
      allow(student).to receive(:user).and_return(fake_user)
      allow(student).to receive(:guardians).and_return(fake_guardian)

      allow_any_instance_of(StudentsController).to receive(:student_params).and_return (hash)

      allow_any_instance_of(StudentsController).to receive(:user_params).and_return ({:first_name => 'John', :last_name => 'Smith', :email => "a@a.com"})
      allow_any_instance_of(StudentsController).to receive(:guardian_params).and_return ({:first_name => 'John', :last_name => 'Smith', :email => "a@a.com"})

      put :update, :id => '1', :guardians => {:id => 1 }
      expect(response).to redirect_to(student_path(student))
    end
  end

  describe 'find a student' do
    it 'should show the student information' do

      allow(@student).to receive(:guardians).and_return([])
      get :show, {:id => '1'}
      expect(response).to render_template('show')
    end

    it 'should show only current student for student login' do

      allow(@student).to receive(:guardians).and_return([])
      allow(@user).to receive(:student).and_return(@student)

      get :show, {:id => '1'}
      expect(response).to render_template('show')
      expect(assigns(:student)).to eq(@user.student)
    end

    it 'should assign guardian by id if nurse' do
      student = double('Student', :id => '1', :user => @user)
      expect(Student).to receive(:find).with('1').and_return(student)
      allow(student).to receive(:guardians).and_return([])

      allow(@user).to receive(:student).and_return(nil)
      get :show, {:id => '1'}
      expect(assigns(:student)).to eq(student)
    end

    it 'should redirect if guardian and not correct student' do
      guardian = double('Guard', :id => '1', :user => @user)
      allow(guardian).to receive(:students).and_return([])

      allow(@user).to receive(:guardian).twice.and_return(guardian)
      get :show, {:id => '1'}
      expect(response).to redirect_to('/login')
    end

    it 'should render if guardian and correct student' do

      @controller = SessionsController.new
      post :create, {"session" => {"email" => "steven@steel.com", "password" => "12345"}}
      @controller = StudentsController.new

      get :show, {:id => '1'}

      expect(assigns(:student)).to eq(Student.find(1))
      expect(response).to render_template('show')
    end
  end

  describe 'pages should redirect when approriate' do
    before :each do
      allow(User).to receive(:find_by_session_token).and_call_original
    end
    it 'index should redirect students' do
      @controller = SessionsController.new
      post :create, {"session" => {"email" => "david@wang.com", "password" => "12345"}}
      @controller = StudentsController.new
      get :index
      expect(response).to redirect_to('/login')
    end

    it 'index should redirect guardians' do
      @controller = SessionsController.new
      post :create, {"session" => {"email" => "putin@vlad.com", "password" => "12345"}}
      @controller = StudentsController.new
      get :index
      expect(response).to redirect_to('/login')
    end

    it 'create should redirect students' do
      @controller = SessionsController.new
      post :create, {"session" => {"email" => "david@wang.com", "password" => "12345"}}
      @controller = StudentsController.new
      get :create
      expect(response).to redirect_to('/login')
    end
    it 'create should redirect guardians' do
      @controller = SessionsController.new
      post :create, {"session" => {"email" => "putin@vlad.com", "password" => "12345"}}
      @controller = StudentsController.new
      get :create
      expect(response).to redirect_to('/login')
    end
    it 'create should redirect administrators' do
      @controller = SessionsController.new
      post :create, {"session" => {"email" => "hell@bear.com", "password" => "12345"}}
      @controller = StudentsController.new
      get :create
      expect(response).to redirect_to('/login')
    end
  end




  describe 'list all students' do
    it 'should find and list all students' do

      @controller = SessionsController.new
      post :create, {"session" => {"email" => "hell@bear.com", "password" => "12345"}}
      @controller = StudentsController.new
      allow(User).to receive(:find_by_session_token).and_call_original

      expect(Student).to receive(:all)

      get :index
      response.should render_template('index')
    end

    it 'should find and list all students from school' do

      @controller = SessionsController.new
      post :create, {"session" => {"email" => "inco@gnito.com", "password" => "12345"}}
      @controller = StudentsController.new
      allow(User).to receive(:find_by_session_token).and_call_original

      expect(Student).to receive(:where).with(school_id: Nurse.find(2).school_id)

      get :index
      response.should render_template('index')
    end
  end
end