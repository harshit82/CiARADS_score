This file contains all the learnings and errors I faced during creation of this project:

Learnings:
- Created camera and saved photos to storage and gallery
- Used sqlite database to store data
- Singleton design pattern in database
- Implemented MVVM design pattern

Errors:
- Another exception was thrown: type 'String' is not a subtype of type 'int' in type cast
- Another exception was thrown: type 'int' is not a subtype of type 'String' in type cast -> Due to the incorrect data type defined in the model
- Unhandled Exception: DatabaseException(unknown database patient_data (code 1 SQLITE_ERROR))
- Unhandled Exception: type 'Null' is not a subtype of type 'List<Map<String, dynamic>>'

Bug:
- https://github.com/flutter/flutter/issues/21911

