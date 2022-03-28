# frozen_string_literal: true

module API
  module V1
    module Bearers
      class ApplicationController < ApplicationController
        def current_bearer
          @current_bearer = Bearer.find(params[:bearer_id])
        end
      end
    end
  end
end
