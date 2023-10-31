

abstract class TaskStates {}

class TaskInitState extends TaskStates {}
// update color index
class UpdateColorIndexState extends TaskStates {}
// date
class GetDateLoadingState extends TaskStates{}
class GetDateSuccessState extends TaskStates{}
class GetDateErrorState extends TaskStates{}
// start time
class GetStartTimeLoadingState extends TaskStates{}
class GetStartTimeSuccessState extends TaskStates{}
class GetStartTimeErrorState extends TaskStates{}
// end time
class GetEndTimeLoadingState extends TaskStates{}
class GetEndTimeSuccessState extends TaskStates{}
class GetEndTimeErrorState extends TaskStates{}
// insert task
class InsertTaskLoadingState extends TaskStates{}
class InsertTaskSuccessState extends TaskStates{}
class InsertTaskErrorState extends TaskStates{}
// get tasks
class GetTasksLoadingState extends TaskStates{}
class GetTasksSuccessState extends TaskStates{}
class GetTasksErrorState extends TaskStates{}
// update tasks
class UpdateTasksLoadingState extends TaskStates{}
class UpdateTasksSuccessState extends TaskStates{}
class UpdateTasksErrorState extends TaskStates{}
// delete tasks
class DeleteTasksLoadingState extends TaskStates{}
class DeleteTasksSuccessState extends TaskStates{}
class DeleteTasksErrorState extends TaskStates{}
// cancel tasks
class CancelTasksLoadingState extends TaskStates{}
class CancelTasksSuccessState extends TaskStates{}
class CancelTasksErrorState extends TaskStates{}
// selected date 
class GetSelectedDateLoadingState extends TaskStates{}
class GetSelectedDateSuccessState extends TaskStates{}
class GetSelectedDateErrorState extends TaskStates{}