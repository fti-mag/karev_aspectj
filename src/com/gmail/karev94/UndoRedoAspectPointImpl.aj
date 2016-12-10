package com.gmail.karev94;

import java.io.Serializable;

public aspect UndoRedoAspectPointImpl extends UndoRedoAspect{
	
	declare parents: Point implements UndoRedo;	
	declare parents: Point implements Serializable;

	pointcut stateChanges(UndoRedo undoRedo):
		target(undoRedo) &&
        call(* Point.set*(double));
}