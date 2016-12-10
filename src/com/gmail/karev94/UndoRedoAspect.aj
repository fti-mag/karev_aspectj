package com.gmail.karev94;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInput;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.lang.reflect.Field;
import java.util.ArrayList;



privileged public abstract aspect UndoRedoAspect {
	public transient ArrayList<byte[]> UndoRedo.stateList = new ArrayList<byte[]>();
	private int UndoRedo.current_state_index = -1;
	
    abstract pointcut stateChanges(UndoRedo undoRedo);
    
    after(UndoRedo undoRedo) : stateChanges(undoRedo)  {
        undoRedo.createNewState();
    }
 
    pointcut init(UndoRedo undoRedo)
    	: (initialization(UndoRedo.new()))
    			&& target(undoRedo);
    
    after(UndoRedo undoRedo) : init(undoRedo) {
    	undoRedo.createNewState();
    }
    
    public void UndoRedo.createNewState() {
    	byte[] serializedObject = serialize(this);
    	if (serializedObject == null) {
    		return;
    	}
    	
    	if(current_state_index < stateList.size() - 1 && current_state_index != -1) {
    		stateList.subList(current_state_index + 1, stateList.size()).clear();
    	}
    	
    	stateList.add(serializedObject);
    	current_state_index++;
    }
    
    private void UndoRedo.moveToState(int state_index) {
    	byte[] serializedObject = stateList.get(state_index);
    	UndoRedo deserializedObject = deserialize(serializedObject);
    	
    	Field[] fields = deserializedObject.getClass().getDeclaredFields();
        for(Field field: fields){
            String fieldName = field.getName();
            if (fieldName.equals("stateList") || fieldName.equals("current_state_index")) {
            	continue;
            }
            try {
            	field.setAccessible(true);
				field.set(this, field.get(deserializedObject));
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			}
        }
    }
    
    public void UndoRedo.undo() {
    	if (stateList.size() < 1) {
    		return;
    	}
    	if (current_state_index <= 0 || current_state_index >= stateList.size()) {
    		return;
    	}
    	
    	this.moveToState(current_state_index - 1);
    	current_state_index--;
    }
    
    public void UndoRedo.redo() {
    	if (stateList.size() < 1) {
    		return;
    	}
    	if (current_state_index < 0 || current_state_index >= stateList.size() - 1) {
    		return;
    	}
    	
    	this.moveToState(current_state_index + 1);
    	current_state_index++;
    }
    
    private byte[] UndoRedo.serialize(UndoRedo undoRedo) {
    	byte[] serializedObject = null;
    	ByteArrayOutputStream bos = null;
        ObjectOutputStream out = null;
        try {
        	bos = new ByteArrayOutputStream();
        	out = new ObjectOutputStream(bos);
            
            out.writeObject(undoRedo);
            out.flush();
            
            serializedObject = bos.toByteArray();
        }
        catch(IOException e)
        {
        	try {
        		bos.close();
        	} catch (IOException ex) {
        	}
        	e.printStackTrace();
        }
        
        return serializedObject;
    }
    
    private UndoRedo UndoRedo.deserialize(byte[] serializedObject) {
    	UndoRedo deserializedObject = null;
    	ByteArrayInputStream bis = new ByteArrayInputStream(serializedObject);
    	ObjectInput in = null;
    	try {
    	  in = new ObjectInputStream(bis);
    	  deserializedObject = (UndoRedo)in.readObject();
    	} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
    	  try {
    	    if (in != null) {
    	      in.close();
    	    }
    	  } catch (IOException ex) {
    	    // ignore close exception
    	  }
    	}
    	
    	return deserializedObject;
    }
}