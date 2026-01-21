# File Picker

`FilePicker` renders a drop target/list for file uploads and uses `FileItem` widgets to describe each file.
- Provide `children` that contain the `FileItem` rows plus a trailing add button, and enable `hotDropEnabled` when you expect drag-and-drop input.
- The `title`/`subtitle` slots let you show instructions and the `onAdd` callback should open your platform picker.

`FileItem` exposes callbacks for remove/retry/download/preview so you can wire the picker to whatever backend you have; plug player/file icons into `thumbnail` to keep the UI consistent.
