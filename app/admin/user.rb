ActiveAdmin.register User do

  
 index do
    column "ID" do |user|
      link_to user.id, admin_user_path(user)
    end                          
    
    column :roles do |user|
      user.roles.collect {|c| c.name.capitalize }.to_sentence    
    end
    actions                   
  end  
 
  show do |ad|
      attributes_table do
        row :id
        
        row :roles do |user|
          user.roles.collect {|r| r.name.capitalize }.to_sentence
        end
      end      
   end
 
  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :roles, :collection => Role.global.order(:name), as: :check_boxes,
        :label_method => lambda { |el| t "simple_form.options.user.roles.#{el.name}" }
    end
    f.actions
  end
  
  controller do   
    def update
      params[:user].each{|k,v| resource.send("#{k}=",v)}      
      super     
    end
 
    def permitted_params
      params.permit user: [:role_ids, :email, :password_confirmation, :password ]
    end
  end
  
end
