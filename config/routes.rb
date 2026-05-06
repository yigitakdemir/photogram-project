Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "users#index"
  # Defines the root path route ("/")
  # root "articles#index"

  get("/users", controller: "users", action: "index")
  get("/users/:username", controller: "users", action: "show")
  post("/add_user", controller: "users", action: "create")
  post("/update_user/:user_id", controller: "users", action: "update")
  get("/photos", controller: "photos", action: "index")
  get("/photos/:photo_id", controller: "photos", action: "show")
  get("/delete_photo/:photo_id", controller: "photos", action: "delete")
  post("/insert_photo_record", controller: "photos", action: "create")
  post("/update_photo/:photo_id", controller: "photos", action: "update")
  post("/insert_comment", controller: "photos", action: "comment")
  
  post("/insert_like", controller: "photos", action: "like")
  get("/delete_like/:like_id", controller: "photos", action: "unlike")

  post("/insert_follow_request", controller: "users", action: "follow")
  get("/delete_follow_request/:f_req_id", controller: "users", action: "unfollow")
  post("/modify_follow_request/:f_req_id", controller: "users", action: "modify")

  get("/users/:username/liked_photos", controller: "users", action: "liked_photos")  
  get("/users/:username/feed", controller: "users", action: "feed")
  get("/users/:username/discover", controller: "users", action: "discover")

end
