public class MathematicallyUndefinedException extends Exception {

	public MathematicallyUndefinedException(){
		super();
	}
	
	public MathematicallyUndefinedException(String message){
		super(message);
	}
	
	public MathematicallyUndefinedException(String message, Throwable cause){
		super(message, cause);
	}
}
