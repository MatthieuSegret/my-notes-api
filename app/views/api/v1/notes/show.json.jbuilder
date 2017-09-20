json.partial! 'api/v1/notes/note', note: @note
json.comments @note.comments, :body, :created_at
