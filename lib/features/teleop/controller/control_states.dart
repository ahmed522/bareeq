abstract class ControlStates {}

class ControlInitState extends ControlStates {}

class ControlLoadingState extends ControlStates {}

class ControlErrorState extends ControlStates {}

class ControlConnectedState extends ControlStates {}

class ControlNotConnectedState extends ControlStates {}

class HideMapState extends ControlStates {}

class UpdateMapState extends ControlStates {}

class DontUpdateMapState extends ControlStates {}
