Tes::Application.routes.draw do


  get "admins/index"

  get "pages/index"

  match "pages/city/:city"=> "pages#city", :as => :state_city, :via => :get
  match "pages/school/:school"=> "pages#school", :as => :school_city, :via => :get
  namespace :admin do

    resources :admins do
      member do
        put "update"
      end
    end

  end

  devise_for :users, :controllers => {:registrations => "devise/registrations" } do
    get "welcome"=> "devise/registrations#index", :as => :welcome

  end


  resources :activity_stream_preferences
  resources :activity_streams
  resources :class_rooms do

    match "reply/:comment_id"=> "comments#reply", :as => :reply_comment, :via => :post

    match "voteable_type/:id/comment_vote/:comment_id"=> "comments#index", :as => :comment_vote, :via => :get
    match "user_profiles/:student_id"=> "user_profiles#index", :as => :user_profile, :via => :get
    devise_for :users, :controllers => {:registrations => "devise/registrations" }, :only =>:edit do
      match "user/:id"=> "devise/registrations#edit", :as => :edit_user, :via => :get

    end

    resources :upload_files do

      member do
        get "comment_new"
        post "comment_create"
        
        get "student/:student_id", :action => "show", :as => :show_student_upload_file
        get "teacher/:teacher_id", :action => "show", :as => :show_teacher_upload_file
        get "comment_student/:student_id", :action => "comment_new", :as => :go_to_student_upload_file
        get "comment_teacher/:teacher_id", :action => "comment_new", :as => :go_to_teacher_upload_file
      end
      
      collection do
        get "download"
        get "student/:student_id", :action => "index", :as => :student_upload_files_index
        get "teacher/:teacher_id", :action => "index", :as => :teacher_upload_files_index
      end
      
    end

    resources :notes do
      
      member do
        get "comment_new"
        post "comment_create"
        get "student/:student_id", :action => "comment_new", :as => :go_to_student_note
        get "teacher/:teacher_id", :action => "comment_new", :as => :go_to_teacher_note
        get "download"
        put "remove_file"
        get "vote_up"
      end

      collection do
        get "student/:student_id", :action => "index", :as => :student_notes_index
        get "teacher/:teacher_id", :action => "index", :as => :teacher_notes_index
      end
    end
    
    resources :to_dos do
      collection do
        get "selected_time"
      end
    end

    resources :messages do
      member do
        get "student/:student_id", :action => "inbox_detail", :as => :student_inbox_detail_observer
        get "teacher/:teacher_id", :action => "inbox_detail", :as => :teacher_inbox_detail_observer

        get "download"
        get "edit_draft"
        post 'delete_draft'
        delete 'student/:student_id', :action => :destroy, :as => :student_observer_message_destroy
        delete 'teacher/:teacher_id', :action => :destroy, :as => :teacher_observer_message_destroy
      end
      collection do
        get "draft"
        get "sent"
        post "destroy_all_data"
        get "student/:student_id/sent", :action => :sent, :as => :student_observer_message_sent
        get "teacher/:teacher_id/sent", :action => :sent, :as => :teacher_observer_message_sent
        get "student/:student_id", :action => :index, :as => :student_observer_message_inbox
        get "teacher/:teacher_id", :action => :index, :as => :teacher_observer_message_inbox
        get "student/:student_id/new", :action => :new, :as => :student_observer_message_new
        get "teacher/:teacher_id/new", :action => :new, :as => :teacher_observer_message_new
        post "student/:student_id", :action => :create, :as => :student_observer_message_create
        post "teacher/:teacher_id", :action => :create, :as => :teacher_observer_message_create
      end
    end

    match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}

    match "messages/inbox_detail/:id"=> "messages#inbox_detail", :as => :inbox_detail, :via => :get
    
    match "messages/sent_detail/:id"=> "messages#sent_detail", :as => :sent_detail, :via => :get
    match "messages/sent_detail/:id/student/:student_id"=> "messages#sent_detail", :as => :student_observer_sent_detail, :via => :get
    match "messages/sent_detail/:id/teacher/:teacher_id"=> "messages#sent_detail", :as => :teacher_observer_sent_detail, :via => :get
    
    match "messages/draft_detail/:id"=> "messages#draft_detail", :as => :draft_detail, :via => :get

    resources :assignments do
      
      member do
        get "comment_new"
        post "comment_create"
        get "student/:student_id", :action => "comment_new", :as => :go_to_student_assignment
        get "teacher/:teacher_id", :action => "comment_new", :as => :go_to_teacher_assignment
        get "download"
        put "remove_file"
        get "edit_assignment_category", :action => "edit_assignment_category", :as => :edit_assignment_category
        put "update_assignment_category", :action => "update_assignment_category", :as => :update_assignment_category
        delete "delete_assignment_category", :action => "delete_assignment_category", :as => :delete_assignment_category
        get "vote_up"
      end

      collection do
        get "student/:student_id", :action => "index", :as => :student_assignments_index
        get "teacher/:teacher_id", :action => "index", :as => :teacher_assignments_index
        get "assignment_category", :action => "assignment_category", :as => :assignment_category
        post "create_assignment_category", :action => "create_assignment_category", :as => :create_assignment_category
        get "new_assignment_category", :action => "new_assignment_category", :as => :new_assignment_category

      end

      resources :writeboards
    end

    resources :writeboards do
      
      member do
        post "comment_create"
        get "comment_edit/:comment_id", :action => "comment_edit", :as => :edit_writeboard_assignment
        delete "comment_destroy/:comment_id", :action => "comment_destroy", :as => :destroy_writeboard_comment
        put "comment_update/:comment_id", :action => "comment_update", :as => :update_writeboard_comment
        get "vote_up"
      end
      
      collection do
        get "student/:student_id", :action => "index", :as => :student_writeboards_index
        get "teacher/:teacher_id", :action => "index", :as => :teacher_writeboards_index
      end
    end

    match "/assignments/:id/comment_edit/:comment_id" => "assignments#comment_edit", :as => :comment_edit_assignment, :via => :get
    match "/assignments/:id/comment_update/:comment_id" => "assignments#comment_update", :as => :comment_update_assignment, :via => :put
    match "/assignments/:id/comment_destroy/:comment_id" => "assignments#comment_destroy", :as => :comment_destroy_assignment, :via => :delete

    match "/events/:id/comment_edit/:comment_id" => "calendar#comment_edit", :as => :comment_edit_event, :via => :get
    match "/events/:id/comment_update/:comment_id" => "calendar#comment_update", :as => :comment_update_event, :via => :put
    match "/events/:id/comment_destroy/:comment_id" => "calendar#comment_destroy", :as => :comment_destroy_event, :via => :delete

    match "/upload_files/:id/comment_edit/:comment_id" => "upload_files#comment_edit", :as => :comment_edit_upload_files, :via => :get
    match "/upload_files/:id/comment_update/:comment_id" => "upload_files#comment_update", :as => :comment_update_upload_files, :via => :put
    match "/upload_files/:id/comment_destroy/:comment_id" => "upload_files#comment_destroy", :as => :comment_destroy_upload_files, :via => :delete

    resources :calendar, :except => [:index, :create, :update]

    resources :events, :controller => :calendar do
      member do
        post "comment_create"
        get "download"
        put "remove_file"
      end
    end

    resources :people do
      collection do
        post "add_person_from_existing_people"
      end

      member do
        delete "remove_from_class"
      end
    end

    match "/notes/:id/comment_edit/:comment_id" => "notes#comment_edit", :as => :comment_edit_notes, :via => :get
    match "/notes/:id/comment_update/:comment_id" => "notes#comment_update", :as => :comment_update_notes, :via => :put
    match "/notes/:id/comment_destroy/:comment_id" => "notes#comment_destroy", :as => :comment_destroy_notes, :via => :delete

   
    resources :discussions do
      member do
        get "comment_new"
        post "comment_create"
        get "student/:student_id", :action => "comment_new", :as => :go_to_student_discussion
        get "teacher/:teacher_id", :action => "comment_new", :as => :go_to_teacher_discussion
        get "download"
        put "remove_file"
      end

      collection do
        get "student/:student_id", :action => "index", :as => :student_discussion_index
        get "teacher/:teacher_id", :action => "index", :as => :teacher_discussion_index
      end
    end

    match "/discussions/:id/comment_edit/:comment_id" => "discussions#comment_edit", :as => :comment_edit_discussions, :via => :get
    match "/discussions/:id/comment_update/:comment_id" => "discussions#comment_update", :as => :comment_update_discussions, :via => :put
    match "/discussions/:id/comment_destroy/:comment_id" => "discussions#comment_destroy", :as => :comment_destroy_discussions, :via => :delete

    match "/student/:student_id" => "class_rooms#show", :as => :student, :via => :get
    match "/teacher/:teacher_id" => "class_rooms#show", :as => :teacher, :via => :get
  end

  resources :events, :only => :show, :controller => :calendar do
    member do
      get "student/:student_id", :action => "show"
      get "teacher/:teacher_id", :action => "show"
    end
  end

  match "/before_activation" => "people#pick_username_and_password", :as => :pick_username_and_password, :via => :get
  match "/activation" => "people#save_username_and_password", :as => :save_username_and_password, :via => :post
  match "/student/:id/dashboard" => "dashboard#index", :as => :student_dashboard, :via => :get
  match "/teacher/:teacher_id/dashboard" => "dashboard#index", :as => :teacher_dashboard, :via => :get
  match "/teacher/:teacher_id/dashboard/student/:student_id/activity_feed" => "dashboard#index", :as => :student_activity_feed, :via => :get
  match 'pages/guest', to: 'pages#guest', as: :guest
  match 'pages/development', to: 'pages#development', as: :development
  match 'users/password/new', to: 'users#password#new', as: :account_help
  devise_for :users

  #  get "dashboard/index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"
  root :to => "dashboard#index"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
