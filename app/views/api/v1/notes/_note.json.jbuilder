json.extract! note, :id, :title, :content
json.author do
  json.name note.user.name
end
json.url api_v1_note_url(note)
