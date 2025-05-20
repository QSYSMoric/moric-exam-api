module V1

  class ApplicationAPI < Grape::API

    format :json

    helpers AuthenticationHelper

    helpers ResponseHelper

  end

end