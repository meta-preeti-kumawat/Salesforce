public class Stack {
    private List<Object> stack = new List<Object>();
    
    public void push(Object element){
        stack.add(element);
    }
    
    public void pop(){
        if(size() == 0){
            throw new StackException('Stack is Empty'); 
        }  
        stack.remove(size() - 1);
    }
    
    public Object peek(){
        if(size() > 0){
            return stack.get(size() - 1); 
        }   
        throw new StackException('Stack is Empty');
    }
    
    public void clear(){
        stack.clear();
    }
    
    public Boolean isEmpty(){
        return stack.isEmpty();   
    }
    
    public Integer size(){
        return stack.size();   
    }
    
    class StackException extends Exception{}
}