import os
import logging
from functools import wraps
from dotenv import load_dotenv

# Cloud Logging imports
from google.cloud import logging as cloud_logging
from google.cloud.logging_v2.handlers import StructuredLogHandler

def with_logging(main_func):
    """Decorator to set up logging based on environment and ensure logs are flushed on exit."""
    @wraps(main_func)
    def wrapper(*args, **kwargs):
        # Load env vars from .env in local dev
        load_dotenv()

        # Choose logging mode
        if os.getenv("LOCAL_ENV") == "true":
            logging.basicConfig(
                level=logging.DEBUG,
                format="%(asctime)s [%(levelname)s] %(message)s",
            )
            logging.info("Local logging initialized.")
        else:
            # Use StructuredLogHandler to avoid threading shutdown issues
            handler = StructuredLogHandler()
            logger = logging.getLogger()
            logger.setLevel(logging.INFO)
            logger.addHandler(handler)

            # Ensure log handler is flushed and closed on shutdown
            import atexit
            atexit.register(handler.flush)
            atexit.register(handler.close)
            logging.info("Google Cloud structured logging initialized.")

        return main_func(*args, **kwargs)

    return wrapper
