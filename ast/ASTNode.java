/**
 * Base class for all AST nodes
 */
public abstract class ASTNode {
    private int lineNumber;
    
    public ASTNode() {
        this.lineNumber = -1;
    }
    
    public ASTNode(int lineNumber) {
        this.lineNumber = lineNumber;
    }
    
    public int getLineNumber() {
        return lineNumber;
    }
    
    public void setLineNumber(int lineNumber) {
        this.lineNumber = lineNumber;
    }
    
    /**
     * Accept method for visitor pattern (optional, for future use)
     */
    public abstract void accept(ASTVisitor visitor);
    
    @Override
    public abstract String toString();
}