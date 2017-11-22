@isTest
private class TestStack {
    static Stack st = new Stack();
    
    @isTest
    static void testStackPeekOperationWhenStackIsEmpty(){
        try{
            st.peek();
        }
        catch(Exception e){
            System.assert(e.getMessage() != null);
        }
    }
    @isTest
    static void testStackPopOperationWhenStackIsEmpty(){
        try{
            st.pop();
        }
        catch(Exception e){
            System.assert(e.getMessage() != null);
        }
    }
    @isTest
    static void testStackPushOperation(){
        st.push(5);
        System.assertEquals(1, st.size());
    }
    @isTest
    static void testStackPopOperationWhenStackIsNotEmpty(){
        System.assertEquals(0, st.size());
        st.push(5);
        System.assertEquals(1, st.size());
        st.pop();
        System.assertEquals(0, st.size());
    }
    @isTest
    static void testStackPeekOperationWhenStackIsNotEmpty(){
        st.push(5);
        System.assertEquals(5, st.peek());
    }
    @isTest
    static void testStackSizeOperation(){
        System.assertEquals(0, st.size());
    }
    @isTest
    static void testStackPushOperationForGenericData(){
        st.push(100);
        st.push('10A');
        st.push(new Account(Name = 'A'));
        System.assertEquals(3, st.size());
    }
    @isTest
    static void testStackClearOperation(){
        st.push(5);
        st.clear();
        System.assertEquals(0, st.size());
    }
    @isTest
    static void testStackIsEmptyOperation(){
        System.assert(st.isEmpty());
        st.push(5);
        System.assert(!st.isEmpty());
    }
}