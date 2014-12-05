module Spree
  module Freshdesk
    class SolutionsController < Spree::StoreController
      before_filter :prepare_data


      def index

      end

      def show

      end

      def contact
        @result = create_support_ticket(params[:ticket])
        if @result == 'success'
          flash[:success] = 'Thank you for contacting support! One of our support staff team members will respond within the next business day.'
          redirect_to help_path
        else
          flash[:error] = @result
          redirect_to "#{help_path}", params
        end

      end

      private

      def create_support_ticket(ticket)
        return 'Sorry, you must enter your name to submit a support ticket' if params[:ticket][:name].blank?
        return 'Sorry, you must enter your e-mail to submit a support ticket' if params[:ticket][:email].blank?
        return 'Sorry, you must enter a message body to submit a support ticket' if params[:ticket][:body].blank?

        description = "
        Name: #{ticket[:name]}
        Order: #{ticket[:order]}
        Subject: #{ticket[:subject]}
          #{ticket[:body]}
        "

        params = {
            helpdesk_ticket: {
                description: description,
                subject: ticket[:subject],
                email: ticket[:email],
                priority: support_priorities[ticket[:subject]],
                status: 2,
                source: 2,
                ticket_type: 'Problem',
                custom_field: {
                    email_address_7483: ticket[:email],
                    order_number_7483: ticket[:order],
                    department_7483: 'Retail- Starkid'
                }
            }
        }

        begin
          if Spree::Freshdesk::Ticket.new(params)
            return 'success'
          end
        rescue ActiveRecord::RecordNotSaved
          return "Sorry, your support ticket was not submitted. Please contact us directly at support@annarbortees.com"
        end
      end

      def prepare_data
        @categories = Spree::Freshdesk::SolutionCategory.all
        @categories.reject! do |category|
          category.folders.reject!{|folder| folder['visibility'] != 1 }
          category.folders.count == 0
        end

        @articles = {}
        @categories.each do |category|
          category.folders.each do |folder|
            @articles[folder['id']] = Spree::Freshdesk::Article.all(category.id, folder['id'])
          end
        end

        @support_subjects = support_subjects
      end


      def support_subjects
         [
            'I need to change an item in my order',
            'I need to change my shipping details',
            'I need to change my shipping method',
            "My order hasn't arrived yet",
            'I received the wrong or a damaged item',
            "I'm missing something I ordered",
            'I need to return/exchange an order',
            "I'm having trouble using the website",
            'I have a general question about a product',
            'Other'
        ]
      end

      def support_priorities
        {
          "I need to change an item in my order" => 4,
          "I need to change my shipping details" => 4,
          "I need to change my shipping method" => 4,
          "My order hasn't arrived yet" => 2,
          "I received the wrong or a damaged item" => 3,
          "I'm missing something I ordered" => 3,
          "I need to return/exchange an order" => 2,
          "I'm having trouble using the website" => 3,
          "I have a general question about a product" => 1,
          "I have a question for StarKid" => 1,
          "Other" => 2
        }
      end

    end
  end
end