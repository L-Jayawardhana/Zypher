/**
 * Visitor interface for traversing AST
 */
public interface ASTVisitor {
    void visit(ProgramNode node);
    void visit(ConfigNode node);
    void visit(VariableNode node);
    void visit(TestNode node);
    void visit(RequestNode node);
    void visit(AssertionNode node);
    void visit(HeaderNode node);
}