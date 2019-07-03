class ChatBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :user, :room, :created_at
  end

  view :extended do
    include_view :normal
    association :messages, blueprint: MessageBlueprint
  end
end
