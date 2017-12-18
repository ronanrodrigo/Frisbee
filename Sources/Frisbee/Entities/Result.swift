public enum Result<Entity> {
    case success(Entity)
    case fail(FrisbeeError)
}
