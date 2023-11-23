This file contains all the learnings and errors I faced during creation of this project:

Learnings:
- Created camera and saved photos to storage and gallery
- Used sqlite database to store data
- Singleton design pattern in database
- Implemented MVVM design pattern
- https://stackoverflow.com/questions/75026752/how-do-i-solve-split-second-flutter-late-initialization-camera-error-in-async-fu
- Created folder and save images in those folders

Errors:
- Another exception was thrown: type 'String' is not a subtype of type 'int' in type cast
- Another exception was thrown: type 'int' is not a subtype of type 'String' in type cast -> Due to the incorrect data type defined in the model
- Unhandled Exception: DatabaseException(unknown database patient_data (code 1 SQLITE_ERROR))
- Unhandled Exception: type 'Null' is not a subtype of type 'List<Map<String, dynamic>>'
- Unhandled Exception: DatabaseException(error database_closed)
- LateError (LateInitializationError: Field 'controller' has not been initialized.)
- PathNotFoundException (PathNotFoundException: Cannot copy file to '/esy_normal_saline/17:48:6.png', path = '/data/user/0/com.example.calposcopy/cache/CAP2144548563826572224.jpg' (OS Error: No such file or directory, errno = 2))
- FileSystemException (FileSystemException: Cannot copy file to '#gsri%green_filter|18:6:50.jpg', path = '/data/user/0/com.example.calposcopy/cache/CAP181698039984606454.jpg' (OS Error: Read-only file system, errno = 30))
- https://stackoverflow.com/questions/75265972/task-appcheckdebugduplicateclasses-failed
- https://stackoverflow.com/questions/75950122/flutter-isolates-the-backgroundisolatebinarymessenger-instance-value-is-invalid
- https://github.com/flutter/flutter/issues/138327
