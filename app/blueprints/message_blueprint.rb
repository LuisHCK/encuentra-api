class MessageBlueprint < Blueprinter::Base
    identifier :id

    fields :user, :chat, :content, :created_at    
end