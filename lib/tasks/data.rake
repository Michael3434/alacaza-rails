
namespace :data do
  desc "Change image_id"
  task image_id: :environment do
    image_id = 2
    User.all.each do |user|
      user.update(image_id: image_id)
      image_id += 1
    end
    User.first.update(image_id: 1)
  end

  desc "Create comment"
  task comment: :environment do
    Comment.create(body: "Ok pour le chauffage arrête .", user: User.find(23))
  end
end
