@isTest
private class TestStack {
    static Stack st = new Stack();
    
    @isTest
    static void testStack(){
        try{
            st.pop();
        }
        catch(Exception e){
            System.assert(e.getMessage() != null);
        }
        try{
            st.peek();
        }
        catch(Exception e){
            System.assert(e.getMessage() != null);
        }
        System.assertEquals(0, st.size());
        st.push(5);
        System.assertEquals(1, st.size());
        System.assertEquals(5, st.peek());
        st.pop();
        System.assertEquals(0, st.size());
        st.push(100);
        st.push('10A');
        st.push(new Account(Name = 'A'));
        st.clear();
        System.assert(st.isEmpty());
    }
}