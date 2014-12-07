json.array!(@tasks) do |task|
  json.extract! task, :id, :title, :content, :state
  json.url task_url(task, format: :json)
end
