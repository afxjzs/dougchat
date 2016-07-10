# By default Volt generates this controller for your Main component
module Main
  class MainController < Volt::ModelController
    model :store

    def index
    end

    def about
    end


    private

    def submit_chat
      store._chats
        .create(body: page._new_chat, created_at: Time.now)
        .then{ page._new_chat = '' }
        .fail{ |err| add_error err}
    end

    def latest_chats
      store._chats
        .limit(20)
        .order({created_at: 1})
    end

    def rdatetime(date)
      if date.present?
        date.strftime("%B %d, %Y %l:%M%P")
      end
    end

    def add_error(err)
      err.each{|k,v| flash_errors.create("#{k}: #{v.join('.')}")}
    end

    # The main template contains a #template binding that shows another
    # template.  This is the path to that template.  It may change based
    # on the params._component, params._controller, and params._action values.
    def main_path
      "#{params._component || 'main'}/#{params._controller || 'main'}/#{params._action || 'index'}"
    end

    # Determine if the current nav component is the active one by looking
    # at the first part of the url against the href attribute.
    def active_tab?
      url.path.split('/')[1] == attrs.href.split('/')[1]
    end
  end
end
