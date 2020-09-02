class Search < ApplicationRecord



	def find_users

			users = User.all
			users = users.where(city_id: city_id) if city_id.present?
			users = users.where(sex: sex) if sex.present?
			users = users.where(religion: religion) if religion.present?

			
		return users
	end
end
