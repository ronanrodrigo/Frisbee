public enum FBEResult<Entity> {
    case success(Entity)
    case fail(FBEError)
}
